package com.jksb.land.common.util.doc;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;


import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
public class DocProcess {

	public static void main(String[] args) {

	}

	/**
	 * 下载网络图片到指定目录
	 * 
	 * @param urlString
	 *            图片URL
	 * @param filename
	 *            保存的图片名称
	 * @param savePath
	 *            保存的文件路径
	 * @throws Exception
	 */
	public static void download(String urlString, String filename,
			String savePath) throws Exception {
		// 构造URL
		URL url = new URL(urlString);
		// 打开连接
		URLConnection con = url.openConnection();
		// 设置请求超时为5s
		con.setConnectTimeout(5 * 1000);
		// 输入流
		InputStream is = con.getInputStream();

		// 1K的数据缓冲
		byte[] bs = new byte[1024];
		// 读取到的数据长度
		int len;
		// 输出的文件流
		File sf = new File(savePath);
		if (!sf.exists()) {
			sf.mkdirs();
		}
		OutputStream os = new FileOutputStream(sf.getPath() + "\\" + filename);
		// 开始读取
		while ((len = is.read(bs)) != -1) {
			os.write(bs, 0, len);
		}
		// 完毕，关闭所有链接
		os.close();
		is.close();
	}

	/**
	 * 创建一个word文档
	 * 
	 * @param txtContent
	 *            要写入word文档的内容
	 * @param fileName
	 *            要保存的word文档路径
	 */
	public static void createWordFile(String txtContent, String fileName) {
		ActiveXComponent app = new ActiveXComponent("Word.Application");// 启动word

		try {
			app.setProperty("Visible", new Variant(false));// 设置word不可见
			Dispatch docs = app.getProperty("Documents").toDispatch();
			Dispatch doc = Dispatch.call(docs, "Add").toDispatch();
			Dispatch selection = Dispatch.get(app, "Selection").toDispatch();
			Dispatch.put(selection, "Text", txtContent);

			Dispatch alignment = Dispatch.get(selection, "ParagraphFormat")
					.toDispatch();// 段落格式
			Dispatch.put(alignment, "Alignment", "1");
			Dispatch font = Dispatch.get(selection, "Font").toDispatch();
			Dispatch.put(font, "Bold", new Variant(true)); // 设置为黑体
			Dispatch.put(font, "Size", new Variant(18)); // 小四

			Dispatch.call(Dispatch.call(app, "WordBasic").getDispatch(),
					"FileSaveAs", fileName);
			Variant f = new Variant(false);
			Dispatch.call(doc, "Close", f);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			app.invoke("Quit", new Variant[] {});
			app.safeRelease();
		}
	}

	/**
	 * 给指定的word文档在字符串指定位置插入图片
	 * 
	 * @param wordFile
	 *            word文档
	 * @param imagePath
	 *            待添加图片的路径
	 * @param str
	 *            指定的字符串位置
	 */
	public static void insertImage(String wordFile, String imagePath,
			String tarStr) {
		//int picWidth = 300;
		//int picHeight = 400;

		ActiveXComponent app = new ActiveXComponent("Word.Application");// 启动word
		try {
			app.setProperty("Visible", new Variant(false));// 设置word不可见

			Dispatch docs = app.getProperty("Documents").toDispatch();

			Dispatch doc = Dispatch.invoke(
					docs,
					"Open",
					Dispatch.Method,
					new Object[] { wordFile, new Variant(false),
							new Variant(false) }, new int[1]).toDispatch();
			// 打开word文件，注意这里第三个参数要设为false，这个参数表示是否以只读方式打开，
			// 因为我们要保存原文件，所以以可写方式打开。

			Dispatch selection = app.getProperty("Selection").toDispatch();

			Dispatch.call(selection, "HomeKey", new Variant(6));// 移到开头

			Dispatch find = Dispatch.call(selection, "Find").toDispatch();// 获得Find组件

			Dispatch.put(find, "Text", tarStr);// 查找字符串tarStr

			Dispatch.call(find, "Execute");// 执行查询

			/*Dispatch picture = */Dispatch.call(
					Dispatch.get(selection, "InLineShapes").toDispatch(),
					"AddPicture", imagePath).toDispatch();// 在指定位置插入图片

			// Dispatch.put(picture, "Width", new Variant(picWidth));
			// Dispatch.put(picture, "Height", new Variant(picHeight));

			Dispatch.call(doc, "Save");// 保存

			Dispatch.call(doc, "Close", new Variant(false));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			app.invoke("Quit", new Variant[] {});
			app.safeRelease();
		}
	}
}
