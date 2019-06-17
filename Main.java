import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class Main {

	public static void main(String[] args) throws IOException {

		ImageReorganization2.overlapImage2(null, ImageIO.read(new File("D:\\barCode\\cnaidc.png")), "产品名称", "产品",
				"d:\\barCode\\test.jpg");
	}

}
