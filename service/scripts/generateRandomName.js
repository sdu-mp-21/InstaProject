function generateRandomName(length = 1) {
  let name = "";

  for (let i = 0; i < length; i++) {
    name += String.fromCharCode(parseInt(Math.random() * 26) + 97);
  }

  return name;
}

module.exports = generateRandomName;
