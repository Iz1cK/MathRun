--!strict
--#region Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--#endregion

--#region Packages
local Packages = ReplicatedStorage.Packages
local Reflex = require(Packages.Reflex)
local Sift = require(Packages.Sift)
local Option = require(Packages.Option)
--#endregion

type Addition = { type: "addition", sign: "+" }
type Subtraction = { type: "subtraction", sign: "-" }
type Multiplication = { type: "multiplication", sign: "*" }
type Division = { type: "division", sign: "/" }

export type Operation = Addition | Subtraction | Multiplication | Division

local Operations = table.freeze({
	Addition = { type = "addition", sign = "+" } :: Addition,
	Subtraction = { type = "subtraction", sign = "-" } :: Subtraction,
	Multiplication = { type = "multiplication", sign = "*" } :: Multiplication,
	Division = { type = "division", sign = "/" } :: Division,
})

type ScoreProducer = Reflex.Producer<ScoreState, ScoreActions>

export type ScoreState = {
	[string]: number?,
}

export type ScoreActions = {
	initializeScore: (playerId: string, value: number) -> (),
	updateScore: (playerId: string, value: number) -> (),
}

local initialState: ScoreState = {}

local scoreSlice: ScoreProducer = Reflex.createProducer(initialState, {
	initializeScore = function(state: ScoreState, id: string)
		return Sift.Dictionary.set(state, id, 0)
	end,
	updateScore = function(state: ScoreState, id: string, value: number, operation: Operation)
		return Sift.Dictionary.update(state, id, function(currentValue: number?)
			local val = Option.Wrap(currentValue)
			if operation.type == Operations.Addition.type then
				val = val:AndThen(function(v: number)
					return Option.Some(v + value)
				end)
			elseif operation.type == Operations.Subtraction.type then
				val = val:AndThen(function(v: number)
					return Option.Some(v - value)
				end)
			elseif operation.type == Operations.Multiplication.type then
				val = val:AndThen(function(v: number)
					return Option.Some(v * value)
				end)
			elseif operation.type == Operations.Division.type then
				val = val:AndThen(function(v: number)
					return Option.Some(v / value)
				end)
			end
			val = val:AndThen(function(v: number)
				return Option.Some(math.max(0, math.round(v)))
			end)
			return val:Unwrap()
		end)
	end,
})

return {
	scoreSlice = scoreSlice,
	Operations = Operations,
}
