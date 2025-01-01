require 'csv'
require 'sqlite3'

module PuzzleHandler

  def find_puzzles_by_theme(db, theme)
    db.execute(<<-SQL, theme)
      SELECT p.*
      FROM puzzles p
      JOIN puzzle_themes pt ON p.id = pt.puzzle_id
      JOIN themes t ON t.id = pt.theme_id
      WHERE t.name = ?
      LIMIT 10;
    SQL
  end

  def find_puzzles(db, theme, limit)
    db.execute(
      "SELECT * FROM puzzles WHERE themes LIKE ? LIMIT ?",
      ["%#{theme}%", limit]
    )
end

  module_function :find_puzzles_by_theme, :find_puzzles
end
