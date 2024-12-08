#!/bin/bash
init()
{
clear
echo "Welcome To ABD File Browser"
echo "Current Working Directory:$PWD"
echo "-------------------------------"
ls -1 --group-directories-first | nl
echo "-------------------------------"

}
init 
