import java.awt.Dimension;
import java.awt.event.KeyEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyListener;

import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JComboBox;

public class Key implements KeyListener{
	public MicroTranslator m;
	Key(MicroTranslator mt){
		m=mt;
	}
	
	public void keyReleased(KeyEvent e){
		if(e.getSource() instanceof JTextField) textFieldKey(e);
		if(e.getSource() instanceof JTextArea) textAreaKey(e);
	}
	
	public void keyPressed(KeyEvent e){}
	public void keyTyped(KeyEvent e){}
	
	private void textFieldKey(KeyEvent e){
		JTextField tf = (JTextField)e.getSource();
		if(tf==m.textField&&m.textField.getText().length()>=15){
			m.textArea.setText(m.textField.getText());
			m.contentPane.removeAll();
			m.contentPane.add(m.bigPane);
			m.getContentPane().setPreferredSize(new Dimension(500,300));
			m.pack();
			m.canSelectAll=false;
			m.textArea.requestFocus();
			m.textArea.setCaretPosition(m.textField.getCaretPosition());
			m.langComboxBig.setSelectedIndex(m.langComboxMain.getSelectedIndex());
		}
	}
	
	private void textAreaKey(KeyEvent e){
		JTextArea ta = (JTextArea)e.getSource();
		if(ta==m.textArea&&m.textArea.getText().length()<15){
			m.textField.setText(m.textArea.getText());
			m.contentPane.removeAll();
			m.contentPane.add(m.mainPane);
			m.getContentPane().setPreferredSize(new Dimension(200,225));
			m.pack();
			m.canSelectAll=false;
			m.textField.requestFocus();
			m.textField.setCaretPosition(m.textArea.getCaretPosition());
			m.langComboxMain.setSelectedIndex(m.langComboxBig.getSelectedIndex());
		}
	}
}