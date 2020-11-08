import java.io.IOException;
import java.net.*;
import javax.swing.*;
import java.awt.*;
import java.net.URL;
import java.io.*;

JLayeredPane pane;
JTextField trans;
JTextField text;
String url="https://script.google.com/macros/s/AKfycbzvbsjOnmB22F4n7hdaEYwRAXnHlIVKgZhv_Rsdg4-Qylo8qw/exec?word=";
void setup() {
	size(200, 190);
	Canvas canvas = (Canvas) surface.getNative();
	pane = (JLayeredPane) canvas.getParent().getParent();
	text = new JTextField();
	trans = new JTextField();
	text.setBounds(10, 10, 180, 30);
	trans.setBounds(10, 150, 180, 30);
	pane.add(text);
	pane.add(trans);
	fill(255,50,20);
	beginShape();
	vertex(80,45);
	vertex(120,45);
	vertex(120,100);
	vertex(140,100);
	vertex(100,140);
	vertex(60,100);
	vertex(80,100);
	endShape(CLOSE);
}

void draw() {
}

void mousePressed(){
	if(text.getText()!=null){
		println("translate");
		try{
			trans.setText(getText(url+URLEncoder.encode(text.getText(), "UTF-8")));
		}catch(IOException e){
		}
	}
}
String getText(String url) throws IOException {
	HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
	int responseCode = connection.getResponseCode();
	InputStream inputStream;
	if (200 <= responseCode && responseCode <= 299) {
		inputStream = connection.getInputStream();
	} else {
		inputStream = connection.getErrorStream();
	}
	BufferedReader in = new BufferedReader(
	new InputStreamReader(
	inputStream));
	StringBuilder response = new StringBuilder();
	String currentLine;
	while ((currentLine = in.readLine()) != null)
		response.append(currentLine);
	in.close();
	return response.toString();
}
