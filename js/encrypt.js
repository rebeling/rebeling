const isNode = typeof window === "undefined";

const encoder = isNode
  ? new (require("util").TextEncoder)()
  : new TextEncoder();
const decoder = isNode
  ? new (require("util").TextDecoder)()
  : new TextDecoder();

function base64Encode(str) {
  return isNode ? Buffer.from(str, "binary").toString("base64") : btoa(str);
}

function base64Decode(str) {
  return isNode ? Buffer.from(str, "base64").toString("binary") : atob(str);
}

function encrypt(text, key) {
  const textBytes = encoder.encode(text);
  const keyBytes = encoder.encode(key);
  const resultBytes = textBytes.map(
    (byte, i) => byte ^ keyBytes[i % keyBytes.length],
  );
  const binaryStr = String.fromCharCode(...resultBytes);
  return base64Encode(binaryStr);
}

function decrypt(encryptedText, key) {
  try {
    const binaryStr = base64Decode(encryptedText);
    const encryptedBytes = Uint8Array.from(binaryStr, (c) => c.charCodeAt(0));
    const keyBytes = encoder.encode(key);
    const decryptedBytes = encryptedBytes.map(
      (byte, i) => byte ^ keyBytes[i % keyBytes.length],
    );
    return decoder.decode(decryptedBytes);
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
