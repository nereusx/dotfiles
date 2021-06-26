#!/bin/sh
app=./ubuntu-pkg
$app -i acpi acpid acpi-call-dkms acpi-support acpitool kacpimon hibernate
