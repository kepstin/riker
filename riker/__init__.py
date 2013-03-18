# -*- coding: utf-8 -*-

import xdg.BaseDirectory
import ConfigParser
import os

_resource = 'riker'
_config_file = 'config.ini'

_config_defaults = {
    'database': 'sqlite:///%(path)s' % \
        {'path': os.path.join(xdg.BaseDirectory.xdg_data_home, _resource, 'library.db')}
}

config = ConfigParser.RawConfigParser(_config_defaults)

def _config_files():
    config_files = []
    for path in xdg.BaseDirectory.xdg_config_dirs:
        config_files.append(os.path.join(path, _resource, _config_file))
    return config_files

def load_config(config_file = None):
    if config_file:
        config.readfp(open(config_file, 'r'))
    else:
        for path in _config_files(config_file):
            if os.path.exists(path):
                config.readfp(open(path, 'r'))
                break
    
    if not config.has_section('server'):
        config.add_section('server')
    
    if not config_file:
        # Save a copy of the default config for a user if they don't have one
        # But only if they're not specifying a custom path
        path = os.path.join(xdg.BaseDirectory.save_config_path(_resource), _config_file)
        if not os.path.exists(path):
            config.write(open(path, 'w'))
