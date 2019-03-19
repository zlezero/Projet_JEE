package Classes;

/**
 *
 * @author tvathonn
 */

public class Joueur {
    
    private Partie[] listeParties;
    private int idJoueur;
    
    public Joueur(int idJoueur, int nbrParties) {
        
        this.idJoueur = idJoueur;
        
        if (nbrParties >= 10) {
            listeParties = new Partie[10];
        }
        else if (nbrParties <= 5) {
            listeParties = new Partie[5];
        }
        else {
            listeParties = new Partie[nbrParties];
        }
            
    }
    
    public void jouer() {
        for (int i = 0; i != listeParties.length; i++) {
            listeParties[i] = new Partie();
            listeParties[i].Jouer();
        }
    }
    
    public Partie getPartie(int i) {
        return listeParties[i];
    }
    
    public int getNbrParties() {      
        return listeParties.length;      
    }
    
    public int getNbrCoupTotal() {
        
        int nbrCoups = 0;
        
        for (int i = 0; i != listeParties.length; i++) {
            if (listeParties[i].getNbrCoups() < 20) {
                nbrCoups += listeParties[i].getNbrCoups();
            }
        }
        
        return nbrCoups;
    }
    
    public int getNbrPartiesSup20Coups() {
        
        int nbrParties = 0;
        
        for (int i = 0; i != listeParties.length; i++) {
            if (listeParties[i].getNbrCoups() > 20) {
                nbrParties += 1;
            }
        }
        
        return nbrParties;
    }
    
    public int getIdJoueur() {
        return idJoueur;
    }
    
}
