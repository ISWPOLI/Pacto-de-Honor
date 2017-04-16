<?php

require_once dirname(__FILE__) . '/ML_Rest_Base.php';

class ML_Rest extends ML_Rest_Base
{
    var $name = '';    
    var $id = null;

    function __construct($api_key){
        parent::__construct();

        $this->apiKey = $api_key;
        $this->path = $this->getPath();

    }

    function setPath($path){
        $this->path = $this->url . $path;
    }

    function getPath()
    {
        return $this->path;
    }

    function setName($name)
    {
        $this->name = $name;
    }

    function setId($id){
        $this->id = $id;

        if ($this->id)
            $this->path = $this->getPath() . '/' . $id . '/';
        else
            $this->path = $this->getPath() . '/';

        return $this;
    }

    function getAll(){
        return $this->execute('GET');
    }

    function get($data = null){
        if (!$this->id)
            throw new InvalidArgumentException('ID is not set.');

        return $this->execute('GET');
    }

    function add($data = null){
        return $this->execute('POST', $data);
    }

    function put($data = null){
        return $this->execute('PUT', $data);
    }

    function remove($data = null){
        return $this->execute('DELETE');
    }
}