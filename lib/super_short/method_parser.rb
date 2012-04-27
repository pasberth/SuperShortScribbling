require 'regparsec'

module SuperShort
  module ParserCombinators
    include RegParsec::Regparsers
    extend self
    Modifier = lambda { |state| one_of *state.modifiers }
    InfixOp = lambda { |state| one_of *state.infix_operators }
    PostModifier = lambda { |state| one_of *state.post_modifiers }
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