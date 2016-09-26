package com.tokbox.android.annotations;


import android.graphics.Paint;

import java.util.UUID;

public class Annotatable {

    private AnnotationsView.Mode mode;
    private String data;

    private String cid;
    private AnnotatableType type;
    private AnnotationsPath path;

    private AnnotationsText text;
    private Paint paint;


    private int canvasWidth;
    private int canvasHeight;

    public Paint getPaint() {
        return paint;
    }

    public static enum AnnotatableType {
        PATH,
        TEXT
    }

    public Annotatable(AnnotationsView.Mode mode, AnnotationsPath path, Paint paint, int canvasWidth, int canvasHeight, String cid) throws Exception{
        if ( cid == null || paint == null || path == null || mode == null || cid.isEmpty() ) {
            throw  new Exception ("Parameters (cid, paint, path or mode) cannot be null.");
        }

        if (canvasHeight >= Integer.MAX_VALUE || canvasWidth >= Integer.MAX_VALUE ){
            throw  new Exception ("CanvasWidth and CanvasHeight values cannot be higher than Integer.MAX_VALUE");
        }

        if (canvasHeight < 0 || canvasWidth < 0 ){
            throw  new Exception ("CanvasWidth and CanvasHeight values cannot be lower than 0");
        }

        this.cid = cid;
        this.mode = mode;
        this.path = path;
        this.canvasWidth = canvasWidth;
        this.canvasHeight = canvasHeight;
        this.paint = paint;
    }

    public Annotatable(AnnotationsView.Mode mode, AnnotationsText text, Paint paint, int canvasWidth, int canvasHeight, String cid) throws Exception {
        if ( cid == null || paint == null || text == null || mode == null || cid.isEmpty() ) {
            throw  new Exception ("Parameters (cid, paint, text or mode) cannot be null.");
        }

        if (canvasHeight >= Integer.MAX_VALUE || canvasWidth >= Integer.MAX_VALUE ){
            throw  new Exception ("CanvasWidth and CanvasHeight values cannot be higher than Integer.MAX_VALUE");
        }

        if (canvasHeight < 0 || canvasWidth < 0 ){
            throw  new Exception ("CanvasWidth and CanvasHeight values cannot be lower than 0");
        }

        this.cid = cid;
        this.mode = mode;
        this.text = text;
        this.canvasWidth = canvasWidth;
        this.canvasHeight = canvasHeight;
        this.paint = paint;
    }

    public void setMode(AnnotationsView.Mode mode) throws Exception{

        if (mode == null ) {
            throw  new Exception ("Mode cannot be null.");
        }
        this.mode = mode;
    }
    public void setData(String data) throws Exception{
        if (data == null ) {
            throw  new Exception ("Data cannot be null.");
        }
        this.data = data;
    }

    public AnnotationsView.Mode getMode() {
        return mode;
    }

    public String getData() {
        return data;
    }

    public AnnotationsPath getPath() {
        return path;
    }

    public void setType(AnnotatableType type) {
        this.type = type;
    }

    public int getCanvasWidth() {
        return canvasWidth;
    }

    public int getCanvasHeight() {
        return canvasHeight;
    }

    public AnnotatableType getType() {
        return type;
    }

    public String getCId() {
        return cid;
    }

    public AnnotationsText getText() {
        return text;
    }

}

