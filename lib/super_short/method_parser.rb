require 'regparsec'

module SuperShort
  module ParserCombinators
    include RegParsec::Regparsers
    extend self
    Modifier = one_of('class', 'try')
    PostModifier = one_of('if!', 'if', 'unless', 'all')
    Verb = apply(/[a-zA-Z0-9]+/, &:join)
    MethodName = one_of(
      apply(Verb, '_', PostModifier) { |v, _, pm| [v, pm] },
      apply(Verb),
      apply(Modifier, '_', proc { MethodName }) { |m, _, (*mn)| [m, *mn] }
    )
  end
end