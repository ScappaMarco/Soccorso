package com.soccorso.model;

class Abilita {
    private int ID;
    private String nome;

    public Abilita(String nome) {
        this.nome = nome;
    }

    public Abilita(int ID, String nome) {
        this.ID = ID;
        this.nome = nome;
    }
}