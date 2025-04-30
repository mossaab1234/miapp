<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Calculadora</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f0f0f0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    table {
      border-collapse: collapse;
      background: #222;
      padding: 10px;
      border-radius: 10px;
    }

    td {
      padding: 10px;
    }

    .display {
      background: #000;
      color: #0f0;
      font-size: 24px;
      text-align: right;
      padding: 10px;
      border-radius: 5px;
      height: 40px;
    }

    .button {
      background: #444;
      color: #fff;
      font-size: 20px;
      width: 60px;
      height: 60px;
      border-radius: 8px;
      text-align: center;
      vertical-align: middle;
      cursor: pointer;
    }

    .button:hover {
      background: #666;
    }

    .button:active {
      background: #888;
    }
  </style>
</head>
<body>

  <table>
    <tr>
      <td colspan="4" class="display">0</td>
    </tr>
    <tr>
      <td class="button">7</td>
      <td class="button">8</td>
      <td class="button">9</td>
      <td class="button">/</td>
    </tr>
    <tr>
      <td class="button">4</td>
      <td class="button">5</td>
      <td class="button">6</td>
      <td class="button">*</td>
    </tr>
    <tr>
      <td class="button">1</td>
      <td class="button">2</td>
      <td class="button">3</td>
      <td class="button">-</td>
    </tr>
    <tr>
      <td class="button">0</td>
      <td class="button">.</td>
      <td class="button">=</td>
      <td class="button">+</td>
    </tr>
    
  </table>

</body>
</html>
