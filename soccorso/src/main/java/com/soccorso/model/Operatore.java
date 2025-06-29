package com.soccorso.model;

import java.time.LocalDate;

/**
 * The type Operatore.
 */
public class Operatore {
    private int ID;
    private String nome;
    private String cognome;
    private String email;
    private int matricola;
    private LocalDate dataNascita;
    private boolean occupato;

    /**
     * Instantiates a new Operatore.
     *
     * @param ID          the id
     * @param nome        the nome
     * @param cognome     the cognome
     * @param email       the email
     * @param matricola   the matricola
     * @param dataNascita the data nascita
     */
// costruttore con ID
    public Operatore(int ID, String nome, String cognome, String email, int matricola, LocalDate dataNascita) {
        this.ID = ID;
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.matricola = matricola;
        this.dataNascita = dataNascita;
        this.occupato = false;
        //default occupato = false
    }

    /**
     * Instantiates a new Operatore.
     *
     * @param nome        the nome
     * @param cognome     the cognome
     * @param email       the email
     * @param matricola   the matricola
     * @param dataNascita the data nascita
     */
// costruttore senza ID
    public Operatore(String nome, String cognome, String email, int matricola, LocalDate dataNascita) {
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.matricola = matricola;
        this.dataNascita = dataNascita;
        this.occupato = false;
    }

    /**
     * Gets id operatore.
     *
     * @return the id operatore
     */
    public int getIdOperatore() {
        return this.ID;
    }

    /**
     * Gets nome operatore.
     *
     * @return the nome operatore
     */
    public String getNomeOperatore() {
        return this.nome;
    }

    /**
     * Sets nome operatore.
     *
     * @param nome the nome
     */
    public void setNomeOperatore(String nome) {
        this.nome = nome;
    }

    /**
     * Gets cognome operatore.
     *
     * @return the cognome operatore
     */
    public String getCognomeOperatore() {
        return this.cognome;
    }

    /**
     * Sets cognome operatore.
     *
     * @param cognome the cognome
     */
    public void setCognomeOperatore(String cognome) {
        this.cognome = cognome;
    }

    /**
     * Gets email operatore.
     *
     * @return the email operatore
     */
    public String getEmailOperatore() {
        return this.email;
    }

    /**
     * Sets email operatore.
     *
     * @param email the email
     */
    public void setEmailOperatore(String email) {
        this.email = email;
    }

    /**
     * Gets matricola operatore.
     *
     * @return the matricola operatore
     */
    public int getMatricolaOperatore() {
        return this.matricola;
    }

    /**
     * Sets matricola operatore.
     *
     * @param matricola the matricola
     */
    public void setMatricolaOperatore(int matricola) {
        this.matricola = matricola;
    }

    /**
     * Gets data nascita operatore.
     *
     * @return the data nascita operatore
     */
    public LocalDate getDataNascitaOperatore() {
        return this.dataNascita;
    }

    /**
     * Sets data nascita operatore.
     *
     * @param dataNascita the data nascita
     */
    public void setDataNascitaOperatore(LocalDate dataNascita) {
        this.dataNascita = dataNascita;
    }

    /**
     * Is operatore occupato boolean.
     *
     * @return the boolean
     */
    public boolean isOperatoreOccupato() {
        return this.occupato;
    }

    /**
     * Sets operatore occupato.
     */
    public void setOperatoreOccupato() {
        this.occupato = true;
    }

    /**
     * Sets operatore non occupato.
     */
    public void setOperatoreNonOccupato() {
        this.occupato = false;
    }
}