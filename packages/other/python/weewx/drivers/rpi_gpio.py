#!/usr/bin/env python

"""
Driver for using custom sensors on the RPi with i2c
"""

from __future__ import with_statement
import syslog
import time

import weewx.drivers

# import sensor libraries
import Adafruit_BMP.BMP085 as BMP085
import Adafruit_DHT
import Adafruit_DHT.Raspberry_Pi as Raspberry_Pi
import SI1145.SI1145 as SI1145
import Adafruit_GPIO.I2C as I2C

"""
default pins on RPi
sda =  3
scl =  5
vcc =  2
v33 =  1
gnd =  6
"""
DEFAULT_MODEL = 'RPI'
DRIVER_NAME = 'RPI_GPIO'
DRIVER_VERSION = '0.1'
DEFAULT_GPIO = '4'
DEFAULT_BUS = '0'

def loader(config_dict, engine):
    return RPI_GPIO_Driver(**config_dict[DRIVER_NAME])

def configurator_loader(config_dict):
    return RPI_GPIO_Configurator()

def confeditor_loader():
    return RPI_GPIO_ConfEditor()

def logmsg(level, msg):
    syslog.syslog(level, 'rpi_gpio: %s' % msg)

def logdbg(msg):
    logmsg(syslog.LOG_DEBUG, msg)

def loginf(msg):
    logmsg(syslog.LOG_INFO, msg)

def logerr(msg):
    logmsg(syslog.LOG_ERR, msg)

class RPI_GPIO_Configurator(weewx.drivers.AbstractConfigurator):
    def add_options(self, parser):
        super(RPI_GPIO_Configurator, self).add_options(parser)
        parser.add_option("--info", dest="info", action="store_true",
                          help="display weather station configuration")
        parser.add_option("--current", dest="current", action="store_true",
                          help="display current weather readings")

    def do_options(self, options, parser, config_dict, prompt):
        self.station = RPI_GPIO_Driver(**config_dict[DRIVER_NAME])
        if options.current:
            self.show_current()
        else:
            self.show_info()

    def show_info(self):
        """Query the station then display the settings."""
        print "using driver %s" % DRIVER_NAME
        print "driver version is %s" % DRIVER_VERSION
        print "using i2c bus %d" % self.station.bus
        print "using GPIO pin %d" % self.station.gpio

    def show_current(self):
        print self.station.get_current()


class RPI_GPIO_Driver(weewx.drivers.AbstractDevice):
    """weewx driver that communicates with RPI GPIO pins."""

    # map sensor names to weewx names
    DEFAULT_LABEL_MAP = { 'ALTITUDE': 'altimeter',
                          'TEMPERATURE': 'outTemp',
                          'HUMIDITY': 'outHumidity',
                          'PRESSURE': 'pressure',
                          'SEALEVEL_PRESSURE': 'barometer',
                          'TIMESTAMP': 'TIMESTAMP',
                          'UV_INDEX': 'UV'
                        }

    def __init__(self, **stn_dict):
        self.bus = int(stn_dict.get('bus', DEFAULT_BUS))
        self.gpio = int(stn_dict.get('gpio', DEFAULT_GPIO))
        self.model = stn_dict.get('model', DEFAULT_MODEL)
        self.max_tries = int(stn_dict.get('max_tries', 5))
        self.retry_wait = int(stn_dict.get('retry_wait', 2))
        self.label_map = stn_dict.get('label_map', self.DEFAULT_LABEL_MAP)
        
        BMP085_I2CADDR = 0x77
        SI1145_I2CADDR = 0x60
        
        try:
            I2C.require_repeated_start()
            BMP085 = I2C.get_i2c_device(BMP085_I2CADDR, busnum=self.bus)
            SI1145 = I2C.get_i2c_device(SI1145_I2CADDR, busnum=self.bus)
            logdbg('Located BMP180 at: %s' % BMP085)
            logdbg('Located SI1145 at: %s' % SI1145)
        except IOError, e:
            logerr("Failed to contact the sensors using bus %d: %s" % (self.bus, e))
            
        loginf('driver version is %s' % DRIVER_VERSION)
        loginf('using i2c bus %d' % self.bus)

    def genLoopPackets(self):
        units = weewx.METRICWX
        ntries = 0
        while ntries < self.max_tries:
            ntries += 1
            try:
                station = RPI_GPIO(self.bus, self.gpio)
                values = station.get_current_data()
                ntries = 0
                data = self._parse_current(values)
                ts = data.get('TIMESTAMP')
                if ts is not None:
                    packet = {'dateTime': ts, 'usUnits': units}
                    packet.update(data)
                    yield packet
            except (weewx.WeeWxIOError, IOError), e:
                logerr("Failed attempt %d of %d to get data: %s" % (ntries, self.max_tries, e))
                logdbg("Waiting %d seconds before retry" % self.retry_wait)
                time.sleep(self.retry_wait)
        else:
            msg = "Max retries (%d) exceeded" % self.max_tries
            logerr(msg)
            raise weewx.RetriesExceeded(msg)

    @property
    def hardware_name(self):
        return self.model

    def get_current(self):
        station = RPI_GPIO(self.bus, self.gpio)
        data = station.get_current_data()
        return self._parse_current(data)

    def _parse_current(self, values):
        return self._parse_values(values)

    def _parse_values(self, values):
        data = {}
        for i, v in enumerate(values):
            label = self.label_map.get(v)
            data[label] = values[v]
        return data

class RPI_GPIO(object):
    def __init__(self, bus, gpio):
        self.bus = int(bus)
        self.gpio = int(gpio)
        
    def _get_temperature(self, temperature):  # C
        label = 'TEMPERATURE'
        data = label, temperature
        return data
        
    def _get_humidity(self, humidity):  # %
        label = 'HUMIDITY'
        data = label, humidity
        return data
        
    def read_dht(self):
        sensor = Adafruit_DHT.AM2302
        humidity, temperature = Adafruit_DHT.read_retry(sensor, self.gpio, retries=5, delay_seconds=2, platform=Raspberry_Pi)
        if humidity is None and temperature is None:
            raise IOError('%d sensor not found on GPIO pin %d' % (sensor, self.gpio))
        else:
            data = self._get_humidity(humidity), self._get_temperature(temperature)
            return data
        
    def get_pressure(self):  # Pa
        label = 'PRESSURE'
        sensor = BMP085.BMP085(mode=BMP085.BMP085_STANDARD, busnum=self.bus)
        value = sensor.read_pressure() / 100  # mbar
        data = label, value
        return data
        
    def get_altitude(self):  # meters
        label = 'ALTITUDE'
        sensor = BMP085.BMP085(mode=BMP085.BMP085_STANDARD, busnum=self.bus)
        value = sensor.read_altitude()
        data = label, value
        return data
        
    def get_sealevel_pressure(self):  # Pa
        label = 'SEALEVEL_PRESSURE'
        sensor = BMP085.BMP085(mode=BMP085.BMP085_STANDARD, busnum=self.bus)
        value = sensor.read_sealevel_pressure(altitude_m=sensor.read_altitude()) / 100  # mbar
        data = label, value
        return data
        
    # BMP temperature sensor
    # not used
    def get_temperature_2(self):  # C
        label = 'TEMERATURE2'
        sensor = BMP085.BMP085(mode=BMP085.BMP085_STANDARD, busnum=self.bus)
        value = sensor.read_temperature()
        data = label, value
        return data
    
    # not used
    def get_visible_light(self):
        label = 'VISIBLE_LIGHT'
        sensor = SI1145.SI1145(busnum=self.bus)
        value = sensor.readVisible()
        data = label, value
        return data
    
    # not used
    def get_infrared(self):
        label = 'INFRARED'
        sensor = SI1145.SI1145(busnum=self.bus)
        value = sensor.readIR()
        data = label, value
        return data
    
    def get_ultraviolet(self):
        label = 'ULTRAVIOLET'
        sensor = SI1145.SI1145(busnum=self.bus)
        value = sensor.readUV()
        data = label, value
        return data
        
    def get_ultraviolet_index(self):
        label = 'UV_INDEX'
        sensor = SI1145.SI1145(busnum=self.bus)
        value = sensor.readUV() / 100.0
        data = label, value
        return data
        
    def get_current_time(self):
        label = 'TIMESTAMP'
        value = int(time.time())
        data = label, value
        return data

    # not used
    def get_voltage(self):
        label = 'VOLTAGE'
        value = True
        data = label, value
        return data

    def get_current_data(self):
        _temperature, _humidity = self.read_dht()
        data = dict([self.get_altitude(),
                     _temperature,
                     _humidity,
                     self.get_pressure(),
                     self.get_sealevel_pressure(),
                     self.get_current_time(),
                     self.get_ultraviolet_index()])
        return data

class RPI_GPIO_ConfEditor(weewx.drivers.AbstractConfEditor):
    @property
    def default_stanza(self):
        return """
[RPI_GPIO]
    # This section is for RPi GPIO sensors.

    # i2c bus such as 0 or 1
    bus = 0
    
    # gpio pin such as 7,17,18,21,22,23,24,25
    gpio = 4

    # The RPI model such as RPI or RPI2
    model = RPI

    # The driver to use:
    driver = weewx.drivers.rpi_gpio
"""

    def prompt_for_settings(self):
        print "Specify the i2c bus, for"
        print "example 0 or 1"
        bus = self._prompt('bus', '0')
        print "Specify the GPIO pin on which the DHT sensor is connected, for"
        print "example 4,7,17,18,21,22,23,24,25"
        gpio = self._prompt('gpio', '4')
        print "Specify the model of RPI, for"
        print "example RPI or RPI2"
        model = self._prompt('model', 'RPI')
        return {'bus': bus, 'gpio': gpio, 'model': model}


# define a main entry point for basic testing without weewx engine and service
# overhead.  invoke this as follows from the weewx root dir:
#
# PYTHONPATH=bin python bin/weewx/drivers/rpi_gpio.py

if __name__ == '__main__':
    import optparse

    usage = """%prog [options] [--help]"""

    syslog.openlog('rpi_gpio', syslog.LOG_PID | syslog.LOG_CONS)
    syslog.setlogmask(syslog.LOG_UPTO(syslog.LOG_DEBUG))
    parser = optparse.OptionParser(usage=usage)
    parser.add_option('--version', dest='version', action='store_true',
                      help='display driver version')
    parser.add_option('--bus', dest='bus', metavar='BUS',
                      help='bus to which the i2c is connected',
                      default=DEFAULT_BUS)
    parser.add_option('--gpio', dest='gpio', metavar='GPIO',
                      help='gpio pin to which the dht sensor is connected',
                      default=DEFAULT_GPIO)
    parser.add_option('--get-current', dest='getcur', action='store_true',
                      help='display current data')
    (options, args) = parser.parse_args()

    if options.version:
        print "RPI_GPIO driver version %s" % DRIVER_VERSION
        exit(0)

    s = RPI_GPIO(options.bus, options.gpio)
    if options.getcur:
        print s.get_current_data()
