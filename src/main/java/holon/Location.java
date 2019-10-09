package holon;

public class Location {
	public double x,y,z;

	public Location(double x, double y, double z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public double distance(Location loc) {
		double x2 = Math.pow(x - loc.x, 2);
		double y2 = Math.pow(y - loc.y, 2);
		double z2 = Math.pow(z - loc.z, 2);
		return Math.sqrt(x2 + y2 + z2);
	}
}
