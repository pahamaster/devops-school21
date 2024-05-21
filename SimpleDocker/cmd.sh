#!/bin/bash

spawn-fcgi -p 8080 miniserver
nginx -g "daemon off;"