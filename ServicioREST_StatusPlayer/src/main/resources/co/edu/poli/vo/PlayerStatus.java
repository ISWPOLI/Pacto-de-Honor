package co.edu.poli.vo;

public class PlayerStatus {

	private int insignias;
	private String tipoUsuario;
	private int puntaje;
	private String personaje;
	private int batallasGanadas;
	private int batallasPerdidas;
	private boolean estado;

	public int getInsignias() {
		return insignias;
	}

	public void setInsignias(int insignias) {
		this.insignias = insignias;
	}

	public String getTipoUsuario() {
		return tipoUsuario;
	}

	public void setTipoUsuario(String tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}

	public int getPuntaje() {
		return puntaje;
	}

	public void setPuntaje(int puntaje) {
		this.puntaje = puntaje;
	}

	public String getPersonaje() {
		return personaje;
	}

	public void setPersonaje(String personaje) {
		this.personaje = personaje;
	}

	public int getBatallasGanadas() {
		return batallasGanadas;
	}

	public void setBatallasGanadas(int batallasGanadas) {
		this.batallasGanadas = batallasGanadas;
	}

	public int getBatallasPerdidas() {
		return batallasPerdidas;
	}

	public void setBatallasPerdidas(int batallasPerdidas) {
		this.batallasPerdidas = batallasPerdidas;
	}

	public boolean isEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

}