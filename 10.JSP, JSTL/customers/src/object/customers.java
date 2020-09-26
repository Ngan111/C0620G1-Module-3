package object;

public class customers {
    private String name;
    private String date_of_birth;
    private String address;
    private String images;

    public customers(String name, String date_of_birth, String address, String images) {
        this.name = name;
        this.date_of_birth = date_of_birth;
        this.address = address;
        this.images = images;
    }

    public customers() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(String date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }
}

