Proyecto: CPE-B-005
===================

Nombre: Clon de Road Fighter
===========================

Institución: Universidad de Buenos Aires - FCEN
===============================================

Integrantes
===========

* Manuel Ferreria
* Juan Pablo Darago
* Matías Pérez

Materia: Diseño de Sistemas con FPGA
====================================

Docente: Patricia Boreztejn
===========================

Descripcion
===========

El juego consiste en un juego inspirado en el clasico juego de Nintendo
Entretainment System (NES) RoadFighter. En esta versión, un auto debe
esquivar el tráfico en una carretera, que se va acelerando con el tiempo.
El puntaje que recibe el jugador esta basado en el tiempo en que puede
evadir los demás autos sin chocarse.

La implementación utiliza una placa de desarrollo con una FPGA Spartan 3E, 
y un pequeño periférico desarrollado por nosotros para poder conectar
joysticks estandar de Sega Genesis y poder reproducir música mediante el
uso de parlantes. 

En un apartado técnico, la implementación esta hecha completamente 
sobre lógica programable y no se han sintetizado unidades de procesamiento.
La lógica esta implementada mediante el lenguaje de descripción de hardware
Verilog. Todo esto se desarrolló en una placa Digilent Spartan 3E que 
cuenta con salida VGA que empleamos para los gráficos del juego, las entradas
y salidas adicionales de joysticks y parlantes utilizan pines de propósito
general. 

Este desarrollo fue realizado como proyecto final de la materia optativa
Diseño de Sistemas con FPGA, dictada en el primer cuatrimestre de 2012
en la Universidad de Buenos Aires, Facultad de Ciencias Exactas y
Naturales.

La música es una adaptación del videojuego clásico de Super Nintendo
Entretainment System (SNES), Chrono Trigger.

Características y funcionalidades
=================================

* Implementación en FPGA Spartan 3E mediante lógica programable, sin 
componentes de computo.
* Uso de salida VGA para gráficos.
* Sintesis y playback de audio de un tema musical. Dos canales: base y
melodía.
* Uso de joystick estandar de Sega Genesis.
* Implementación de pseudoaleatoriedad en base a entropía generada por 
el jugador, para una experiencia más desafiante.
