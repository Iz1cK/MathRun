local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Reflex = require(ReplicatedStorage.Packages.Reflex)
local Score = require(script.Slices.Score)

export type RootProducer = Reflex.Producer<RootState, RootActions>

export type RootState = {
	score: Score.ScoreState,
}

type RootActions = Score.ScoreActions

export type Operation = Score.Operation

return {
	rootProducer = Reflex.combineProducers({
		score = Score.scoreSlice,
	}) :: RootProducer,
	Operations = Score.Operations,
}
