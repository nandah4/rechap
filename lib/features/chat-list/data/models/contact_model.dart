import 'package:flutter_contacts/properties/phone.dart';
import 'package:flutter_contacts/properties/email.dart';
import 'package:flutter_contacts/properties/address.dart';
import 'package:flutter_contacts/properties/website.dart';
import 'package:flutter_contacts/properties/social_media.dart';
import 'package:flutter_contacts/properties/event.dart';
import 'dart:typed_data';

class Contact {
  String id;
  String displayName;
  Uint8List? photo;
  Uint8List? thumbnail;
  Name name;
  List<Phone> phones;
  List<Email> emails;
  List<Address> addresses;
  List<Organization> organizations;
  List<Website> websites;
  List<SocialMedia> socialMedias;
  List<Event> events;
  List<Note> notes;
  List<Group> groups;
  Contact({
    required this.id,
    required this.displayName,
    this.photo,
    this.thumbnail,
    required this.name,
    required this.phones,
    required this.emails,
    required this.addresses,
    required this.organizations,
    required this.websites,
    required this.socialMedias,
    required this.events,
    required this.notes,
    required this.groups,
  });
}

class Name {
  String first;
  String last;

  Name({required this.first, required this.last});
}

class Phone {
  String number;
  PhoneLabel label;

  Phone({required this.number, required this.label});
}

class Email {
  String address;
  EmailLabel label;

  Email({required this.address, required this.label});
}

class Address {
  String address;
  AddressLabel label;

  Address({required this.address, required this.label});
}

class Organization {
  String company;
  String title;

  Organization({required this.company, required this.title});
}

class Website {
  String url;
  WebsiteLabel label;

  Website({required this.url, required this.label});
}

class SocialMedia {
  String userName;
  SocialMediaLabel label;

  SocialMedia({required this.userName, required this.label});
}

class Event {
  int? year;
  int month;
  int day;
  EventLabel label;

  Event({
    this.year,
    required this.month,
    required this.day,
    required this.label,
  });
}

class Note {
  String note;
  Note({required this.note});
}

class Group {
  String id;
  String name;

  Group({required this.id, required this.name});
}
