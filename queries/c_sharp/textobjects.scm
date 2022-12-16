; Class and struct outer
[
    (class_declaration)
    (struct_declaration)
] @class.outer

; Class inner braces
(class_declaration 
  body: (declaration_list . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "class.inner" @_start @_end)))

; Struct inner braces
(struct_declaration
  body: (declaration_list . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "class.inner" @_start @_end)))

; Method and lamba outer
[
    (method_declaration)
    (lambda_expression)
] @function.outer

; Method inner braces
(method_declaration
  body: (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "function.inner" @_start @_end)))

; Function inner braces
(lambda_expression 
  body: (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "function.inner" @_start @_end)))

;; --- loops ---

; All loop outers
[
    (for_statement)
    (for_each_statement)
    (do_statement)
    (while_statement)
] @loop.outer

; For loop inner braces
(for_statement
  body: (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "loop.inner" @_start @_end)))

; For loop no braces
(for_statement
  body: (_) @loop.inner)

; For each inner braces
(for_each_statement
  body: (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "loop.inner" @_start @_end)))

; For each inner no braces
(for_each_statement
  body: (_) @loop.inner)

; Do inner braces
(do_statement
  (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "loop.inner" @_start @_end)))

; Do inner no braces
(do_statement
  (_) @loop.inner)

; While inner braces
(while_statement
  (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "loop.inner" @_start @_end)))

; While inner no braces ; WARNING: Might not always work
(while_statement
  (expression_statement) @loop.inner)

;; --- conditionals ---

; If outer
(if_statement) @conditional.outer

; If alternative inner braces
(if_statement
  alternative: (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "conditional.inner" @_start @_end)))

; If alternative no braces
(if_statement
  alternative: (_) @conditional.inner)

; If consequence inner parenthesis
(if_statement
  consequence: (block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "conditional.inner" @_start @_end)))

; If consequence inner no parenthesis
(if_statement
  consequence: (_) @conditional.inner)

; TODO
(switch_statement
  body: (switch_body) @conditional.inner) @conditional.outer

;; --- calls ---

; Call outer
(invocation_expression) @call.outer

; Call inner parenthesis
(invocation_expression
  arguments: (argument_list . "(" . (_) @_start (_)? @_end . ")"
  (#make-range! "call.inner" @_start @_end)))

;; --- blocks ---

; TODO
(_ (block) @block.inner) @block.outer

;; --- parameters ---

((parameter_list
  "," @_start . (parameter) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner)) 

((parameter_list
  . (parameter) @parameter.inner . ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end)) 

((argument_list
  "," @_start . (argument) @parameter.inner)
 (#make-range! "parameter.outer" @_start @parameter.inner)) 

((argument_list
  . (argument) @parameter.inner . ","? @_end)
 (#make-range! "parameter.outer" @parameter.inner @_end)) 

;; --- comments ---

(comment) @comment.outer
