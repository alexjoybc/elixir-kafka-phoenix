<?php

namespace App\Handler;

use App\Models\Booking;
use Psr\Log\LoggerInterface;
use Symfony\Component\Messenger\Handler\MessageHandlerInterface;

class BookingHandler implements MessageHandlerInterface
{

    private $_logger;

    public function __construct(LoggerInterface $logger)
    {
        $this->_logger = $logger;
    }


    public function __invoke(Booking $message)
    {
        $this->_logger->info("received new message: " . $message->getId());
    }


}

