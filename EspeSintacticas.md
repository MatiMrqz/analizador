# Especificaciones sintácticas

```
STMT ::= LHS = COMMAND [do ['|'[BLOCK_VAR]'|'] COMPSTMT end]
COMMAND ::= OPERATION CALL_ARGS | super CALL_ARGS
```