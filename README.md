# Bezos

[![Build Status] [status]] [travis]

![bezos] [bezos]

## Description

Bezos timestamps and signs requests to various Amazon APIs.

## Installation

```bash
npm install bezos
```

## Usage

```coffee
Bezos = require 'bezos'

bezos = new Bezos secret
bezos.sign url

[status]: https://secure.travis-ci.org/hakanensari/bezos.png
[travis]: http://travis-ci.org/hakanensari/bezos
[bezos]: http://f.cl.ly/items/0v1h130h3Q181s3W312e/bezos.png
