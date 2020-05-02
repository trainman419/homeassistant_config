import asterisk.manager
import logging
import voluptuous as vol
import homeassistant.helpers.config_validation as cv

from homeassistant.const import CONF_HOST, CONF_PORT, CONF_USERNAME, CONF_PASSWORD
import homeassistant.loader as loader

_LOGGER = logging.getLogger(__name__)

REQUIREMENTS = ['pyst2==0.5.0']

NOTIFICATION_ID = 'asterisk_setup'
NOTIFICATION_TITLE = 'Asterisk Setup'

DOMAIN = 'asterisk'

CONFIG_SCHEMA = vol.Schema({
    DOMAIN: vol.Schema({
        vol.Required(CONF_HOST): cv.string,
        vol.Required(CONF_USERNAME): cv.string,
        vol.Required(CONF_PASSWORD): cv.string,
        vol.Optional(CONF_PORT, default=5038): cv.positive_int,
    }),
}, extra=vol.ALLOW_EXTRA)


def setup(hass, config):
    conf = config[DOMAIN]
    host = conf.get(CONF_HOST)
    port = conf.get(CONF_PORT)
    username = conf.get(CONF_USERNAME)
    password = conf.get(CONF_PASSWORD)
    _LOGGER.info("Asterisk component is now set up")

    astmanager = asterisk.manager.Manager()
    try:
        astmanager.connect(host, port)
        astmanager.login(username, password)
        hass.data['asterisk_manager'] = astmanager # this object is used by astext. Pass it on
        return True
    except:
        _LOGGER.error("Could not connect to asterisk server")
        return False
