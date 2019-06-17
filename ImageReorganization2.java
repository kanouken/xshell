import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;

/**
 * 照片编辑器
 */
public class ImageReorganization2 {

	public static BufferedImage resizeImage(int x, int y, BufferedImage bfi) {
		BufferedImage bufferedImage = new BufferedImage(x, y, BufferedImage.TYPE_INT_RGB);
		bufferedImage.getGraphics().drawImage(bfi.getScaledInstance(x, y, Image.SCALE_SMOOTH), 0, 0, null);
		return bufferedImage;
	}

	public static void overlapImage2(String backgroundPath, BufferedImage bufferedImage, String message01,
			String message02, String outPutPath) {
		try {

			GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
			String[] fa = ge.getAvailableFontFamilyNames();
			for (String s : fa) {
			}

			BufferedImage background = resizeImage(250, 200, new BufferedImage(250, 200, BufferedImage.TYPE_INT_RGB));
			BufferedImage qrCode = resizeImage(200, 115, bufferedImage);

			Graphics2D g = background.createGraphics();
			g.setColor(Color.WHITE);
			// 填充整个屏幕
			g.fillRect(0, 0, 250, 200);
			g.setColor(Color.BLACK);
			Font f = new Font("宋体", Font.PLAIN, 15);
			// g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
			// RenderingHints.VALUE_ANTIALIAS_ON);
			g.setFont(f);
			g.getFontMetrics(f);
			g.drawString(message01, 65, 155);
			g.drawString(message02, 30, 180);
			g.drawImage(qrCode, 25, 20, qrCode.getWidth(), qrCode.getHeight(), null);
			g.dispose();
			ImageIO.write(background, "jpg", new File(outPutPath));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
