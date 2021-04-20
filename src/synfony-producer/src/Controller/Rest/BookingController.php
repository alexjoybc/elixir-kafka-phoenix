<?php

namespace App\Controller\Rest;

use App\Models\Booking;
use FOS\RestBundle\Controller\AbstractFOSRestController;
use FOS\RestBundle\View\View;
use FOS\RestBundle\Controller\Annotations as Rest;
use Ramsey\Uuid\Rfc4122\UuidV4;
use Ramsey\Uuid\Uuid;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Messenger\MessageBus;
use Symfony\Component\Messenger\MessageBusInterface;

/**
 * The booking controller
 */
class BookingController extends AbstractFOSRestController
{

    private $_bus;

    public function __construct(MessageBusInterface $bus)
    {
        $this->_bus = $bus;
    }

    /**
     * Creates an Article resource
     * 
     * @param Request $request the booking request
     * 
     * @Rest\Post("/bookings")
     * 
     * @return View
     */
    public function postBooking(Request $request): View
    {
        $booking = new Booking();

        $parameters = json_decode($request->getContent(), true);

        $booking->setId(Uuid::uuid4()->toString());
        $booking->setState($parameters['state']);

        $this->_bus->dispatch($booking);

        return View::create($booking, Response::HTTP_CREATED);
    }

    /**
     * Get a booking
     * 
     * @Rest\Get("/bookings")
     * 
     * @return View
     */
    public function getBookings(): View
    {
        $booking = new Booking();
        $booking->setId(Uuid::uuid4()->toString());
        $booking->setState("yeah");
        return View::create($booking, Response::HTTP_OK);
    }

}
    