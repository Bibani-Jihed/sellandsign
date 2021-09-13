import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellandsign/constants/colors.dart';
import 'package:sellandsign/models/contractor/contractor.dart';

class ContractorCard extends StatefulWidget {
  final Contractor contractor;

  @override
  _ContractorCardState createState() => _ContractorCardState();

  ContractorCard({
    required this.contractor,
  });
}

class _ContractorCardState extends State<ContractorCard> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      title: Text(
        "${widget.contractor.firstname} ${widget.contractor.lastname}",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      baseColor: Colors.black45,
      expandedColor: Colors.blueGrey,
      shadowColor: Colors.black,
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 0.1,
          color: Colors.grey,
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 1,
          childAspectRatio: 10,
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            Container(
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.email,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: widget.contractor.email!.isEmpty
                            ? "{{empty}}"
                            : widget.contractor.email,
                      ),
                    ],
                  )),
            ),
            Container(
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.volunteer_activism,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: widget.contractor.civility!.isEmpty
                            ? "{{empty}}"
                            : widget.contractor.civility,
                      ),
                    ],
                  )),
            ),
            Container(
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: widget.contractor.address_1!.isEmpty
                            ? "{{empty}}"
                            : widget.contractor.address_1,
                      ),
                    ],
                  )),
            ),
            Container(
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: widget.contractor.address_2!.isEmpty
                            ? "{{empty}}"
                            : widget.contractor.address_2,
                      ),
                    ],
                  )),
            ),
            Container(
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.home,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: widget.contractor.postal_code!.isEmpty
                            ? "{{empty}}"
                            : widget.contractor.postal_code,
                      ),
                    ],
                  )),
            ),
            Container(
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.location_city,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: widget.contractor.city!.isEmpty
                            ? "{{empty}}"
                            : widget.contractor.city,
                      ),
                    ],
                  )),
            ),
            Container(
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.phone,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: widget.contractor.cell_phone!.isEmpty
                            ? "{{empty}}"
                            : widget.contractor.cell_phone,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
