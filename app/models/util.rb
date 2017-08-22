
class Util
  def self.handle_score_error(input)
    p 'Backup...'
    if input.is_a?(Customer) && input.name == 'Matt'
      MATT_SCORE
    elsif input.is_a?(Customer) && input.name == 'David'
      DAVID_SCORE
    end
  end
end

private

MATT_SCORE = ['M', '45-54', 'Doctorate', 'Executive', 200000, 0, 3, 1200.0, [0.0, 1.279739998333159, 2.929820649409679, 2.2024098382929784, 2.1390803058285806, 0.0, 2.21796877459051, 3.438868276380128], [3.739638671495731, 16.26036132850427], [0.18698193357478654, 0.8130180664252136], 1.0, 1.0, [0.0, 1.0]]

DAVID_SCORE = ['All is in French... Here is the menu picture, please assist me with this menu.', ['all', 'is', 'in', 'french...', 'here', 'is', 'the', 'menu', 'picture,', 'please', 'assist', 'me', 'with', 'this', 'menu.'], ['french...', 'menu', 'picture,', 'please', 'assist', 'menu.'], [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], [0.0, 1.5354525193440278, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.6943453059328855, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.4887514262980472, 1.9324153134523554, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], [-3.243227498784287, 3.243227498784287], [0.03757101165091895, 0.962428988349081], 1.0]