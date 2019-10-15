package holon.tech.text_editor;

import java.util.LinkedList;
import java.util.ListIterator;

class Buffer {
    private LinkedList<String> lines;

    private Buffer() {
        lines = new LinkedList<String>();
    }

    public static Buffer fromString(String dat) {
        String lines[] = dat.split("\\r?\\n");
        Buffer rv = new Buffer();
        for(String line: lines){
            rv.lines.add(line);
        }
        if(dat.charAt(dat.length()-1) == '\n') {
            rv.lines.add("");
        }

        return rv;
    }

    public boolean bufferReady() {
        return lines != null;
    }

    public boolean canGetLines(int startIndex, int num) {
        return startIndex >= 0 &&
            startIndex + num <= lines.size() &&
            bufferReady();
    }

    public String[] getLines(int startIndex, int num) throws Exception {
        if(!canGetLines(startIndex, num)) {
            String dat = "startIndex: " + startIndex + ", " +
                "num: " + num + ", " + "bufferReady: " + bufferReady();
            throw new IndexOutOfBoundsException(dat);
        }

        String[] rv = new String[num];
        ListIterator<String> it = lines.listIterator(startIndex);
        for(int i = 0; i < startIndex + num; i++){
            rv[i] = it.next();
        }

        return rv;
    }
}
