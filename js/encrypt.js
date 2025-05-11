const isNode = typeof window === "undefined";

function base64Encode(str) {
  return isNode ? Buffer.from(str, "binary").toString("base64") : btoa(str);
}

function base64Decode(str) {
  return isNode ? Buffer.from(str, "base64").toString("binary") : atob(str);
}

function encrypt(text, key) {
  let result = "";
  for (let i = 0; i < text.length; i++) {
    const charCode = text.charCodeAt(i) ^ key.charCodeAt(i % key.length);
    result += String.fromCharCode(charCode);
  }
  return base64Encode(result);
}

function decrypt(encryptedText, key) {
  try {
    const text = base64Decode(encryptedText);
    let result = "";
    for (let i = 0; i < text.length; i++) {
      const charCode = text.charCodeAt(i) ^ key.charCodeAt(i % key.length);
      result += String.fromCharCode(charCode);
    }
    return result;
  } catch (e) {
    console.error("Decryption failed:", e);
    return "";
  }
}

if (isNode) {
  const args = process.argv.slice(2);
  const command = args[0];
  const text = args[1];
  const key = args[2];

  if (!command || !text || !key) {
    console.log("Usage:");
    console.log('  Encrypt: node encrypt.js encrypt "your text" "your key"');
    console.log(
      '  Decrypt: node encrypt.js decrypt "encrypted text" "your key"',
    );
    process.exit(1);
  }

  if (command === "encrypt") {
    const encrypted = encrypt(text, key);
    console.log("Encrypted text:", encrypted);
  } else if (command === "decrypt") {
    const decrypted = decrypt(text, key);
    console.log("Decrypted text:", decrypted);
  } else {
    console.log('Invalid command. Use "encrypt" or "decrypt"');
    process.exit(1);
  }
}
