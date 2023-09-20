return {
	["score"] = 0,
	["addScore"] = function(self, amount)
		self.score = self.score + amount
	end,
	["getScore"] = function(self)
		return self.score
	end,
	["setScore"] = function(self, score)
		if score < 0 then
			score = 0
		end
		self.score = math.round(score)
	end,
}
