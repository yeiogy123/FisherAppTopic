
import 'package:flutter/material.dart';

class ProgressDialog extends StatefulWidget {
  Color BackgroundColor, color, ContainerColor;
  double borderRadius;
  String text = '\0' ;
  bool opacity;
  late ProgressDialogState progressDialogState;


  ProgressDialog({
    this.BackgroundColor = Colors.black12,
    this.color = Colors.white70,
    this.ContainerColor = Colors.transparent,
    this.borderRadius = 10.0,
    this.text = '\0',
    this.opacity = false
  });


  @override
  createState() => progressDialogState = new ProgressDialogState(
    BackgroundColor:this.BackgroundColor,
    color:this.color,
    ContainerColor:this.ContainerColor,
    borderRadius:this.borderRadius,
    text:this.text,
    opacity:this.opacity
  );


  void Hide(){
    progressDialogState.hide();
  }
  void Show(){
    progressDialogState.show();
  }
  void ShowProgressWithText(String Title){
    progressDialogState.ShowProgressWithText(Title);
  }
  static ProgressDialog GetProgressDialog(String Title, bool Opacity){
    return new ProgressDialog(
        BackgroundColor : Colors.black12,
        color : Colors.white70,
        ContainerColor : Colors.transparent,
        borderRadius: 5.0,
        text : Title,
        opacity : Opacity
    );
  }
}

class ProgressDialogState extends State<ProgressDialog> {
  Color BackgroundColor, color, ContainerColor;
  double borderRadius;
  String text ='\0';

  bool opacity;

  ProgressDialogState({
    this.BackgroundColor = Colors.black26,
    this.color = Colors.white,
    this.ContainerColor = Colors.transparent,
    this.borderRadius = 10.0,
    this.text ='\0',
    this.opacity = false
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: !opacity
            ? null
            : new Opacity(
            opacity: opacity ? 1.0 : 0.0,
            child: new Stack(
              children: <Widget>[
                new Center(
                  child: new Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        color: ContainerColor,
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(borderRadius))
                    ),
                  ),
                ),
                new Center(
                  child: GetCenterContent(),
                )
              ],
            )
        )
    );
  }

  Widget GetCenterContent() {
    if (Text == null) {
      return GetCircularProgress();
    }
    return new Center(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          GetCircularProgress(),
            new Container(
              child: new Text(
                text,
                style: new TextStyle(color:color)
              )
            )
      ],
    ));
  }

  Widget GetCircularProgress(){
    return new CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation(color),
    );
  }

  void hide(){
    setState(() {
      opacity = false;
    });
  }

  void show(){
    setState(() {
      opacity = true;
    });
  }

  void ShowProgressWithText(String Title){
    setState(() {
      opacity = true;
      text = Title;
    });
  }
}
