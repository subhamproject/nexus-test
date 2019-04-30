#!/bin/bash
mvn -s settings.xml release:clean release:prepare release:perform
