from homeassistant.helpers.entity import Entity
from homeassistant.components.sensor import PLATFORM_SCHEMA
from homeassistant.const import CONF_HOST, CONF_PORT, CONF_USERNAME, CONF_PASSWORD
import homeassistant.helpers.config_validation as cv
import voluptuous as vol
import logging
import socket
import re

_LOGGER = logging.getLogger(__name__)

DEPENDENCIES = ['asterisk']

PLATFORM_SCHEMA = PLATFORM_SCHEMA.extend({
    vol.Required('extension'): cv.string
})


def setup_platform(hass, config, add_devices, discovery_info=None):
    extension = config.get('extension')
    _LOGGER.info("Setting up asterisk extension device for extension {}".format(extension))
    add_devices([AsteriskExtension(hass, extension)], True)

class AsteriskExtension(Entity):
    def __init__(self, hass, extension):
        self._hass = hass
        self._astmanager = hass.data.get('asterisk_manager')
        self._extension = extension
        self._state = "Unknown"
        self._astmanager.register_event('ExtensionStatus', self.handle_asterisk_event)
        _LOGGER.info("Asterisk extention device initialized")

    def handle_asterisk_event(self, event, astmanager):
        extension = event.get_header('Exten')
        status = event.get_header('StatusText')
        if (extension == self._extension):
            _LOGGER.info ("Got asterisk event for extension {}: {}".format(extension,status))
            self._state = status
            self.hass.async_add_job(self.async_update_ha_state())

    @property
    def name(self):
        return "Asterisk Extension {}".format(self._extension)

    @property
    def state(self):
        return self._state

    def update(self):
        result = self._astmanager.extension_state(self._extension,"")
        self._state = result.get_header("StatusText")
