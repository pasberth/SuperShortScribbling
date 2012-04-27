require 'regparsec'
require 'give4each'

module SuperShort
  module ParserCombinators
    include RegParsec::Regparsers
    extend self
    Modifier = lambda { |state| one_of *state.modifiers }
    InfixOp = lambda { |state| one_of *state.infix_operators }
    PostModifier = lambda { |state| one_of *state.post_modifiers }
    Verb = lambda { |state|
      try apply(/[a-zA-Z](?:(?!#{
        (state.infix_operators + state.object_words + state.post_modifiers).map(&:quote.in(Regexp)).map(&:%.in('(?:_%s)')).join('|')
      })\w)*[a-zA-Z0-9]?/, &:join) }
    Objw = lambda { |state| one_of *state.object_words }
    MethodName = one_of(
      apply(Modifier, '_', proc { MethodName }) { |m, _, (*mn)| [m, *mn] },
      apply(Verb, '_', Objw) { |v, _, ow| [v, ow] },
      apply(Verb)
    )
    InfixExp = one_of(
      apply(MethodName, '_', InfixOp, '_', MethodName) { |m1, _1, iop, _2, m2| [iop, m1, m2] },
      MethodName
    )
    PModExp = one_of(
      apply(InfixExp, '_', PostModifier) { |iexp, _, pm| [*iexp, pm] },
      InfixExp
    )
    ModifiableMethodName = PModExp
  end
end