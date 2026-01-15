#!/bin/bash
../greentic-component/target/debug/greentic-component test \
  --wasm target/wasm32-wasip2/release/component_templates.wasm \
  --manifest ./component.manifest.json \
  --op text \
  --input-json '{
    "config": { "templates": { "text": "Hello {{payload.name}}", "output_path": "text" } },
    "msg": {
      "id": "msg-1",
      "tenant": { "env": "dev", "tenant": "default", "tenant_id": "default", "session_id": "s-1", "attempt": 1 },
      "channel": "chat",
      "session_id": "s-1",
      "user_id": null,
      "text": "hello",
      "attachments": [],
      "metadata": {}
    },
    "payload": { "name": "Greentic" }
  }' \
  --pretty
