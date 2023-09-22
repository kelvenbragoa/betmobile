import 'package:estivadorapp/models/user.dart';
import 'package:flutter/material.dart';

//codelab test url

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color.fromARGB(255, 255, 255, 255);

const defaultPadding = 16.0;

const baseURL = 'http://192.168.18.222:8000/api';
const url = 'http://192.168.18.222:8000/storage/';

const loginURL = baseURL + '/login';

const homeURL = baseURL+ '/home';

const transactionURL = baseURL + '/transactions';

const userURL = baseURL;

const getDetailURL =  baseURL + '/getdetails';

const serverError ='Erro. Verifique sua conexão e tente novamente.';

const unauthorized = 'Não autorizado';

const somethingwentwrong = 'Erro inesperado. Tente Novamente.';

User userProfile = User(
    id: id,
    name: name,
    username: username,
    email: email,
    role: role); 

var id;
var username;
var name;
var email;
var role;
