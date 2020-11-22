package MicroTranslator;
import MicroTranslator.*;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.FocusAdapter;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class Focus implements FocusListener{
	public MicroTranslator m;
	public Focus(MicroTranslator mt){
		m=mt;
	}
	
	public void focusGained(FocusEvent e){
		if(e.getSource() instanceof JTextArea) textAreaAction(e);
		if(e.getSource() instanceof JTextField) textFieldAction(e);
	}
	
	public void focusLost(FocusEvent e){
		
	}
	
	private void textAreaAction(FocusEvent e){
		JTextArea ta = (JTextArea)e.getSource();
		if(!m.canSelectAll||!m.isSelectAll){
			m.canSelectAll=true;
			return;
		}
		ta.selectAll();
	}
	
	private void textFieldAction(FocusEvent e){
		JTextField tf = (JTextField)e.getSource();
		if(!m.canSelectAll||!m.isSelectAll){
			m.canSelectAll=true;
			return;
		}
		tf.selectAll();
	}
}