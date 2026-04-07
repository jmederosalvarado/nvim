;; extends

; Keep Rust function/method contexts to just the identifier.
(function_item
  (identifier) @context.start @context.final) @context
