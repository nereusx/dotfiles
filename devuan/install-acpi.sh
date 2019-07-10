#!/bin/sh
app=./deb-pkg
$app -i acpi acpid acpi-call-dkms acpi-support acpitool kacpimon hibernate
