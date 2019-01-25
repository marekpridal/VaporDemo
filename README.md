<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>

# VaporDemo
Demo of using Swift for server app

<h3 style="color:rgb(38, 180, 127);">GET</h3>

`/exchanges`

<a href="https://vapordemo.herokuapp.com/exchanges" style="color:rgb(38, 180, 127);">Try 🙌</a>

`/exchangeRate`

<a href="/exchangeRate?countryCode=CZK" style="color:rgb(38, 180, 127);">Try 🙌</a>
<h3 style="color:rgb(255, 203, 79);">POST</h3>

`/exchange`

<b>JSON BODY example</b><br>

```
{
  "country_code":"EUR",
  "value":1,
  "timestamp":null,
  "priority":1
}
```

<a href="https://vapordemo.herokuapp.com/exchanges" style="color:rgb(255, 203, 79);">Try 🙌</a>

<h3 style="color:rgb(9, 123, 237);">PUT</h3>

`/exchange`

<b>JSON BODY example</b><br>

```
{
  "country_code":"CZK",
  "value":25.644444,
  "timestamp":null,
  "priority":1
}
```

<a href="https://vapordemo.herokuapp.com/exchanges" style="color:rgb(9, 123, 237);">Try 🙌</a>

<h3 style="color:rgb(237, 75, 72);">DELETE</h3>

`/exchange`

<b>JSON BODY example

```
{
  "country_code":"CZK",
  "value":25.644444,
  "timestamp":null,
  "priority":1
}
```

<a href="https://vapordemo.herokuapp.com/deleteExchangeRate" style="color:rgb(237, 75, 72);">Try 🙌</a><
