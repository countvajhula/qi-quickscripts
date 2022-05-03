#lang scribble/manual
@(require racket/runtime-path
          racket/dict
          racket/match
          quickscript/base)

@(define-runtime-path scripts-path "../scripts")

@;; If calling this function is slow, compile the scripts first.

@(define (get-script-help-strings scripts-path)
   (filter
    values
    (for/list ([filename (in-list (directory-list scripts-path #:build? #f))])
      (define filepath (build-path scripts-path filename))
      (and (script-file? filepath)
           (cons (path->string (path-replace-extension filename #""))
                 (get-script-help-string filepath))))))
@(define help-strings (get-script-help-strings scripts-path))

@title{Qi-Quickscripts}

Some @(hyperlink "https://github.com/Metaxal/quickscript" "Quickscript") scripts
to make it easier to work with @(hyperlink "https://docs.racket-lang.org/qi/index.html" "Qi") in DrRacket.

@section{Installation}

In DrRacket, in @tt{File|Package manager|Source}, enter @tt{Qi-Quickscripts}.

Or, on the command line, type: @tt{raco pkg install Qi-Quickscripts}.

If DrRacket is already running, click on @tt{Scripts|Manage scripts|Compile scripts}.

@section{Scripts}


@(itemlist
  (for/list ([(name str) (in-dict help-strings)])
    (item (index name @(bold name)) ": "
          (let loop ([str str])
            (match str
              ;; link
              [(regexp #px"^(.*)\\[([^]]+)\\]\\(([^)]+)\\)(.*)$" (list _ pre txt link post))
               (list (loop pre)
                     (hyperlink link txt)
                     (loop post))]
              [else str])))))
@;{
 ;}

Insert ☯ on c:;

Insert △ on c:u

Insert ▽ on c:s:u

Insert ⏚ on c:=

Insert ~> on c:>

Insert -< on c:<



@section{Customizing}

Scripts can be selectively deactivated from the library
(@tt{Scripts|Manage scripts|Library}).

If you change the source code of a script installed from the @tt{Qi-Quickscripts} package
(or from any package containing quickscripts), you will lose all your modifications when the package
is updated.
To avoid this, you can use Quickscript's
@hyperlink["https://docs.racket-lang.org/quickscript/index.html?q=quickscripts#%28part._.Shadow_scripts%29"]{shadow scripts}:
The shadow script calls the original script without modifying it, and can be modified to your taste
without being modified when the original script is updated.

In particular, if you want to change the default label, menu path or keybinding of a script installed
from @tt{Qi-Quickscripts}, go to @tt{Scripts|Manage|Library…}, select the @tt{Qi-Quickscripts}
directory, then the script you want, and click on @tt{Shadow}.
This opens a new (shadow) script that calls the original script where you can change what you want.

Note that the shadowed script is deactivated so as to avoid duplicate menu entries and keybindings.
