#!/bin/bash
mvn -X -s settings.xml release:clean release:prepare release:perform
