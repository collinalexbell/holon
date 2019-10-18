package holon.biology;

import java.util.Set;

public class FurCoat {
	private enum Color {
		BROWN, RED, GOLD, YELLOW, CREAM, BLACK, BLUE, GRAY, WHITE
	}
	
	private enum Pattern {
		SOLID, SIMPLE_MULTI, TUXEDO, HARLEQUIN, SPOTTED, FLECKED, BRINDLE, SADDLE, STRIPED, TICKED;
	}
	
	private enum Length {
		BALD, SHORT, MEDIUM, LONG;
	}
	
	private Set<Color> colors;
	private Pattern pattern;
	private Length length;
	
	public Set<Color> getColors(){
		return colors;
	}
	
	public void addColor(Color c) {
		colors.add(c);
	}
	
	public void removeColor(Color c) {
		colors.remove(c);
	}
	
	public Pattern getPattern() {
		return pattern;
	}
	
	public void setPattern(Pattern p) {
		pattern = p;
	}
	
	public void setLength(Length l) {
		length = l;
	}
}
