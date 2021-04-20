<?php
namespace App\Models;

class Booking {

    private $id;

    private $state;

    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id=$id;
    }

    public function getState() {
        return $this->state;
    }

    public function setState($state) {
        $this->state=$state;
    }


}


