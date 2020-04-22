# Runkit7
A Chassis extension to install and configure [Runkit7](https://github.com/runkit7/runkit7) on your Chassis server.

## Global Installation

We recommend [installing this extension globally](http://docs.chassis.io/en/latest/extend/#globally-installing-extensions) to make it available on every Chassis box.

```
git clone https://github.com/Chassis/runkit7 ~/.chassis/extensions/runkit7
```

## Project Installation
1. Add this extension to your extensions directory `git clone git@github.com:Chassis/runkit7.git extensions/runkit7` or alternatively add the following to one of your [`.yaml`](https://github.com/Chassis/Chassis/blob/master/config.yaml) files:
   ```
   extensions:
     - chassis/runkit7
   ```
2. Set your `config.local.yaml` PHP version to 7.0 or higher.
3. Run `vagrant provision`.

Contributors: [@banderon](https://github.com/banderon).