require 'regparsec'

module SuperShort
  module ParserCombinators
    include RegParsec::Regparsers
    extend self
    Modifier = one_of('class', 'try', 'will')
    InfixOp = one_of('or', 'and')
    PostModifier = one_of('if!', 'if', 'unless', 'all_in', 'all', 'in')
    Verb = try apply(/[a-zA-Z0-9]+/, &:join)
    MethodName = one_of(
      apply(Verb, '_', PostModifier) { |v, _, pm| [v, pm] },
      apply(Modifier, '_', proc { MethodName }) { |m, _, (*mn)| [m, *mn] },
      apply(Verb)
    )
    InfixExp = one_of(
      apply(MethodName, '_', InfixOp, '_', MethodName) { |m1, _1, iop, _2, m2| [iop, m1, m2] },
      MethodName
    )
  end
end